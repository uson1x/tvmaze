FactoryGirl.define do
  factory 'TVMaze::Episode' do
    id { rand(1000) }
    number { rand(100) }
    season { rand(100) }
    name 'Mega episode 123'
    summary 'Some long text over here. Some long text over here. Some long text over here.'
  end
end
