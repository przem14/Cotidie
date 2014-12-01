class PolishLanguagePack
  attr_reader :home_page,
              :sign_in, :sign_up, :sign_out,
              :name, :surname, :email, :personal_id, :role, :is_approved,
              :password, :password_confirmation, :current_password,
              :teacher, :tutor, :student, :admin, :roles,
              :show, :edit, :update, :sure, :delete,
              :delete_account, :back,
              :admin_panel, :missing_admin_rights, :missing_rights, :editing_user,
              :student_panel, :tutor_panel, :teacher_panel, :not_approved, :wait_for_admin,
              :subjects, :classes, :users, :degrees,
              :subject_name, :class, :subject, :educator, :students, :add_students,
              :delete_from_class, :deleted_from_class,
              :new_subject, :add_subject, :edit_subject, :new_class, :edit_class,
              :degree, :description, :activity, :insert_degrees, :edit_degree,
              :choose_subject, :created, :degrees_errors,
              :set_student, :set, :student_set,
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
    @delete = 'Usuń'
    @sure   = 'Jesteś pewny?'

    @delete_account = 'Usuń konto'
    @back = 'Wstecz'

    @admin_panel          = 'Panel Administracyjny'
    @editing_user         = 'Edytuj użytkownika'
    @missing_admin_rights = 'Nie posiadasz uprawnień administratora'
    @missing_rights       = 'Nie posiadasz wymaganych uprawnień'

    @student_panel  = 'Panel ucznia'
    @tutor_panel  = 'Panel rodzica'
    @teacher_panel  = 'Panel nauczyciela'
    @not_approved   = 'Nie zostałeś jeszcze zatwierdzony przez administratora'
    @wait_for_admin = 'Poczekaj, aż administrator zweryfikuje Twoje konto'

    @subjects       = 'Przedmioty'
    @classes        = 'Klasy'
    @users          = 'Użytkownicy'
    @degrees        = 'Oceny'

    @subject_name   = 'Nazwa'
    @class          = 'Klasa'
    @subject        = 'Przedmiot'
    @educator       = 'Wychowawca'
    @students       = 'Uczniowie'
    @add_students   = 'Dodaj uczniów'

    @delete_from_class  = 'Usuń z klasy'
    @deleted_from_class = 'Pomyślnie usunięto ucznia z klasy'

    @new_subject    = 'Nowy przedmiot'
    @add_subject    = 'Dodaj przedmiot'
    @edit_subject   = 'Edytuj przedmiot'
    @new_class      = 'Nowa klasa'
    @edit_class     = 'Edytuj klasę'

    @degree         = 'Ocena'
    @activity       = 'Czynność'
    @description    = 'Opis'
    @insert_degrees = 'Wystaw oceny'
    @edit_degree    = 'Edytuj ocenę'

    @choose_subject = 'Wybierz przedmiot'
    @created        = 'Wystawiono'
    @degrees_errors = 'Wykryto błędy w trakcie wystawiania ocen. Wprowadź poprawne wartości'

    @set_student  = 'Nie podałeś jeszcze kogo rodzicem jesteś'
    @set          = 'Ustaw'
    @student_set  = 'Pomyślnie ustawiono rodzicielstwo'

    @yes      = 'Tak'
    @no       = 'Nie'
    @approved = {true => @yes, false => @no}

    @user_updated = 'Pomyślnie zaktualizowano użytkonika'
    @user_deleted = 'Pomyślnie skasowano użytkonika'
    @self_destroy = 'Nie możesz usunąć siebie samego'
  end
end