module AccountHeroesHelper
  def show_target_stars(account_hero)
    account_hero.new_record? || (account_hero.hero && (account_hero.level > 0))
  end

  def show_target_stars_label(account_hero, stars)
    account_hero.new_record? || stars.between?(account_hero.target.stars, account_hero.target.max_stars)
  end
end
