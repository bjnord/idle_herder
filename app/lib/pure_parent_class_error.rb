class PureParentClassError < StandardError
  def initialize(msg="Can't directly instantiate pure parent class")
    super
  end
end
