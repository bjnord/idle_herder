module AccountHeroesHelper
  def show_target_stars(account_hero)
    account_hero.new_record? || (account_hero.hero && account_hero.leveled?)
  end

  def show_target_stars_label(account_hero, stars)
    account_hero.new_record? || stars.between?(account_hero.target.stars, account_hero.target.max_stars)
  end

  def shards_count_class(account_hero)
    none = account_hero.sharded? ? '' : 'none'
    maxed = (account_hero.sharded? && (account_hero.shards >= account_hero.target.max_shards)) ? 'maxed' : ''
    "shards-count #{none} #{maxed}".strip
  end

  def shard_fraction(account_hero)
    return "&nbsp;".html_safe if !account_hero.sharded?
    "#{account_hero.shards} / #{account_hero.target.max_shards}"
  end
end
