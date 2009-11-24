ActiveRecord::Schema.define(:version => 1) do
  create_table :offices, :force => true do |t|
    t.string :main, :abroad, :chicago, :boston, :paris, :lyon
  end
end