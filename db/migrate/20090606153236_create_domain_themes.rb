class CreateDomainThemes < ActiveRecord::Migration
  def self.up
    create_table :domain_themes, :force => true do |t|
      t.string  :uri
      t.string  :name
    end
    add_index :domain_themes, ["uri"]
  end

  def self.down
    drop_table :domain_themes
  end
end
