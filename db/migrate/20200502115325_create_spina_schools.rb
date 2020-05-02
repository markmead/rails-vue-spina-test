class CreateSpinaSchools < ActiveRecord::Migration[6.0]
  def change
    create_table :spina_schools do |t|
      t.string :title
      t.string :county
      t.integer :min_age
      t.integer :max_age
    end
  end
end
