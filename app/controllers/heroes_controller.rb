class HeroesController < ApplicationController
  def index
    # FIXME move to Hero class (as class method), and add filtering inputs
    @hero_tree = Hash.new {|h, k| h[k] = Hash.new {|ha, ke| ha[ke] = [] } }
    Hero.all.each do |hero|
      @hero_tree[hero.stars][hero.faction] << hero
    end
  end

  def show
    @hero = Hero.find(params[:id])
  end
end
