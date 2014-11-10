class PolishLanguagePack
  attr_reader :home_page,
              :sign_in, :sign_up, :sign_out,
              :name, :surname, :email, :personal_id, :role, :is_approved,
              :password, :password_confirmation, :current_password,
              :teacher, :tutor, :student, :admin, :roles,
              :show, :edit, :update, :sure,
              :delete_account, :back,
              :admin_panel, :missing_admin_rights, :editing_user,
              :yes, :no, :approved,
              :user_deleted, :user_updated, :self_destroy

  def initialize
    @home_page = 'Strona główna'

    @sign_in  = 'Zaloguj się'
    @sign_up  = 'Zarejestruj się'
    @sign_out = 'Wyloguj się'

    @name         = 'Imię'
    @surname      = 'Nazwisko'
    @email        = 'Email'
    @personal_id  = 'PESEL'
    @role         = 'Rodzaj uprawnień'
    @is_approved  = 'Zatwierdzony'
    @password     = 'Hasło'
    @password_confirmation  = 'Potwierdź hasło'
    @current_password       = 'Aktualne hasło'

    @teacher  = 'Nauczyciel'
    @tutor    = 'Rodzic'
    @student  = 'Uczeń'
    @admin    = 'Administrator'
    @roles    = {'admin'   => @admin,
                 'student' => @student,
                 'tutor'   => @tutor,
                 'teacher' => @teacher}

    @show   = 'Pokaż'
    @edit   = 'Edytuj'
    @update = 'Zapisz'
    @sure   = 'Jesteś pewny?'

    @delete_account = 'Usuń konto'
    @back = 'Wstecz'

    @admin_panel          = 'Panel Administracyjny'
    @editing_user         = 'Edytuj użytkownika'
    @missing_admin_rights = 'Nie posiadasz uprawnień administratora'

    @yes      = 'Tak'
    @no       = 'Nie'
    @approved = {true => @yes, false => @no}

    @user_updated = 'Pomyślnie zaktualizowano użytkonika'
    @user_deleted = 'Pomyślnie skasowano użytkonika'
    @self_destroy = 'Nie możesz usunąć siebie samego'
  end
end