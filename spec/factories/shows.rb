FactoryGirl.define do
  factory 'TVMaze::Show' do
    id { rand(1000) }
    name 'Super Duper Show!'
    language 'en'
    summary 'Some long text over here. Some long text over here. Some long text over here.'
  end
end
