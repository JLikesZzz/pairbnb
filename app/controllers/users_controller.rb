class UsersController < Clearance::UsersController
before_action :check_current_user, only: [:edit, :update]
before_action :custom_params, only: [:update]




  def edit
   @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(custom_params)
      redirect_to "/users/#{@user.id}"
    else
      flash[:warning] = 'Y U DO THIS'
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def user_from_params

      email = user_params.delete(:email)
      password = user_params.delete(:password)
      first_name = user_params.delete(:first_name)
      last_name = user_params.delete(:last_name)
      birthdate= [user_params.delete('birthdate(1i)'),
                  user_params.delete('birthdate(2i)'),
                  user_params.delete('birthdate(3i)')].join('-')
      # gender = user_params.delete(:gender)
      # contact_number = user_params.delete(:contact_number)
      # description = user_params.delete(:description)
      # country = user_params.delete(:country)

      Clearance.configuration.user_model.new(user_params).tap do |user|
        user.email = email
        user.password = password
        user.first_name = first_name
        user.last_name = last_name
        user.birthdate = birthdate
        # user.gender = gender
        # user.contact_number = contact_number
        # user.description = description
        # user.country = country
      end
    end

    def permit_params
      params.require(:user).permit(:email, :password, :first_name, :last_name, 'birthdate(1i)', 'birthdate(2i)', 'birthdate(3i)')
                                  # , :gender, :contact_number, :description, :country)
    end

    def custom_params
      params.require(:user).permit(:first_name, :last_name, :birthdate, :gender, :contact_number, :description, :country, :avatar)
    end

    def check_current_user
      unless params[:id].to_i == current_user.id
        redirect_to '/'
      end
    end
end
