class UsersController < Clearance::UsersController

  def edit
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

end
