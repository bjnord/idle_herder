module HeroesHelper
  def fmt_name(hero)
    "#{hero.name}#{hero.natural? ? '‹n›' : ''}"
  end

  def fmt_title(hero)
    "#{hero.stars}★ #{hero.name}" + (hero.respond_to?(:role) ? " (#{hero.role})" : '')
  end

  def fmt_subtitle(hero)
    natural_label = (hero.natural? && (hero.stars == 5)) ? 'Natural ' : ''
    "#{natural_label}#{hero.stars}★ #{hero.faction_name}" + (hero.respond_to?(:role) ? " (#{hero.role})" : '')
  end
end
