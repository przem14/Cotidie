class PolishLanguagePack
  attr_reader :sign_in, :sign_up, :sign_out,
              :name, :surname, :personal_id, :role,
              :password, :password_confirmation, :current_password,
              :teacher, :tutor, :student, :admin,
              :edit, :update,
              :delete_account

  def initialize
    @sign_in  = 'Zaloguj się'
    @sign_up  = 'Zarejestruj się'
    @sign_out = 'Wyloguj się'

    @name         = 'Imię'
    @surname      = 'Nazwisko'
    @personal_id  = 'PESEL'
    @role         = 'Rodzaj uprawnień'
    @password     = 'Hasło'
    @password_confirmation  = 'Potwierdź hasło'
    @current_password       = 'Aktualne hasło'

    @teacher  = 'Nauczyciel'
    @tutor    = 'Rodzic'
    @student  = 'Uczeń'
    @admin    = 'Administrator'

    @edit   = 'Edytuj'
    @update = 'Zapisz'

    @delete_account = 'Usuń konto'
  end
end