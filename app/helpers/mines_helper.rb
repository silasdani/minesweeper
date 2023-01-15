module MinesHelper
  SPOT_MAPPER = {
    ' ' => ' ',
    'F' => '🚩',
    '-1' => '💣',
    '1' => "<span style='color: #0000ff'>1</span>".html_safe,
    '2' => "<span style='color: #00ff00'>2</span>".html_safe,
    '3' => "<span style='color: #ff0000'>3</span>".html_safe,
    '4' => "<span style='color: #000000'>4</span>".html_safe,
    '5' => "<span style='color: #ef00ff'>5</span>".html_safe,
    '6' => "<span style='color: #006dde'>6</span>".html_safe,
    '7' => "<span style='color: #ff8000'>7</span>".html_safe,
    '8' => "<span style='color: #808080'>8</span>".html_safe,
    '9' => '',
    '0' => "<span style='color: #808080'>A</span>".html_safe,
  }.freeze

  def spot_to_emoji(spot)
    SPOT_MAPPER[spot]
  end
end
