require 'rails_helper'

RSpec.describe WorkOut, type: :model do
  context 'データが正しく保存される' do
    before do
      @workout = WorkOut.new
      @workout.muscle_group = 'gmax_legs'
      @workout.effect = 'my_limit'
      @workout.place = 'outdoors'
      @workout.time = '15'
      @workout.save
    end
    it '全て入力してあるので保存される' do
      expect(@workout).to be_valid
    end
  end
end
