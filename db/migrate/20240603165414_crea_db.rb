class CreaDb < ActiveRecord::Migration[6.1]
  def change
    # Create the users table
    create_table :users do |t|
      t.string :username, null: false
      #t.string :email, null: false
      #t.string :password_digest, null: false
      t.references :university_details, null: true, foreign_key: { to_table: :universities }
      t.references :account, null: true, foreign_key: true
      t.string :role, :default => 'user'
      

      t.timestamps
    end

    # Create the universities table
    create_table :universities do |t|
      t.string :name, null: false

      t.timestamps
    end

    # Create the courses table
    create_table :courses do |t|
      t.string :name, null: false
      t.references :university, null: false, foreign_key: true

      t.timestamps
    end

    # Create the accounts table
    create_table :accounts do |t|
      t.string :google_oauth2, default: 'false'
      t.string :github, default: 'false'
      t.references :user, null: true, foreign_key: true
      t.timestamps
    end

    # Create the notes table
    create_table :notes do |t|
      t.string :title, null: false
      t.string :pdf, null: false
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.string :tags
      t.boolean :visibility
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end

    # Create the reviews table
    create_table :reviews do |t|
      t.string :title, null: false
      t.text :text, null: false
      t.integer :rating, null: false
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.references :note, null: false, foreign_key: true

      t.timestamps
    end

    # Create the user_reports table
    create_table :user_reports do |t|
      t.text :report, null: false
      t.string :subject, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    # Create the note_reports table
    create_table :note_reports do |t|
      t.text :report, null: false
      t.string :subject, null: false
      t.references :note, null: false, foreign_key: true

      t.timestamps
    end

    # Create the review_reports table
    create_table :review_reports do |t|
      t.text :report, null: false
      t.string :subject, null: false
      t.references :review, null: false, foreign_key: true

      t.timestamps
    end

    # Create the tickets table
    create_table :tickets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :subject, null: false
      t.text :text, null: false

      t.timestamps
    end
  end
end
