class ConnectFourMatcher
  def initialize(lines)
    @lines = lines
  end

  def winner
    @lines.map { |line| line.join.match(/(\w)\1{3}/) }
          .compact
          .map { |match| match.to_s[0] }
          .first
  end
end
