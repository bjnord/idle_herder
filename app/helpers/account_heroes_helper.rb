module AccountHeroesHelper
  def show_target_stars(account_hero)
    account_hero.new_record? || (account_hero.specific? && !account_hero.sharded?)
  end

  def show_target_stars_label(account_hero, stars)
    account_hero.new_record? || stars.between?(account_hero.stars, account_hero.max_stars)
  end

  def shards_count_class(account_hero)
    "shards-count#{account_hero.sharded? ? '' : ' none'}#{account_hero.max_sharded? ? ' maxed' : ''}"
  end

  def shard_fraction(account_hero)
    return "&nbsp;".html_safe if !account_hero.sharded?
    "#{account_hero.shards} / #{account_hero.max_shards}"
  end
end
