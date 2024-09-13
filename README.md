# ShareYourNotes

HOW TO EXECUTE TESTS: 

RAILS_ENV=test rails db:drop

RAILS_ENV=test rails db:create

RAILS_ENV=test rails db:migrate

RAILS_ENV=test rake db:seed:all

rails cucumber

ShareYourNotes è un'applicazione che permette a studenti universitari di condividere i propri appunti con gli altri. L'applicazione deve permettere creare categorie e sotto-categorie (esempio: facoltà, corso di laurea) da associare agli appunti che verranno caricati dagli utenti (in formato pdf). Deve essere inoltre possibile associare dei tag ai file in modo da poter effettuare ricerche e recuperare tutti gli appunti appartenenti a uno specifico tag, rilasciare recensioni su un particolare file condiviso (un valore esempio da 1 a 5, che può essere usato come filtro nelle ricerche), scaricare i file e anche caricarli direttamente sullo spazio google  drive personale. Sono previsti almeno due tipi di utenti: amministratore (l'unico che può creare categorie e i tag) e l'utente (può caricare i propri appunti associandoli alle rispettive categorie e tag, ricercare appunti e rilasciare un feedback sugli appunti degli altri). 
Esempio di API: Autenticazione tramite XXX (a scelta), google drive
