module HeroesHelper
  def fmt_name(hero)
    "#{hero.name}#{hero.natural ? '‹n›' : ''}"
  end
end
