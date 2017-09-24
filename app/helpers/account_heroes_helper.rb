module AccountHeroesHelper
  def show_target_stars_label(account_hero, stars)
    account_hero.new_record? || stars.between?(account_hero.stars, account_hero.max_stars)
  end
end
