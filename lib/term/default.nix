{ lib }:

{
  fmt = {
    reset = ''\e[0m'';

    weight.bold = ''\e[1m'';
    weight.light = ''\e[2m'';
    weight.normal = ''\e[22m'';

    italic.on = ''\e[3m'';
    italic.off = ''\e[23m'';

    underline.on = ''\e[4m'';
    underline.double = ''\e[21m'';
    underline.off = ''\e[24m'';

    blink.slow = ''\e[5m'';
    blink.fast = ''\e[6m'';
    blink.off = ''\e[25m'';

    rev.on = ''\e[7m'';
    rev.off = ''\e[27m'';

    hide.on = ''\e[8m'';
    hide.off = ''\e[28m'';

    strike.on = ''\e[9m'';
    strike.off = ''\e[29m'';

    fg.set = c: ''\e[${toString (c + 30)}m'';
    fg.default = ''\e[39m'';

    bg.set = c: ''\e[${toString (c + 40)}m'';
    bg.default = ''\e[49m'';

    font.default = ''\e[10m'';
    font.alt = n: ''\e[${toString (n + 10)}m'';
  };

  colors = {
    black = 0;
    red = 1;
    green = 2;
    yellow = 3;
    blue = 4;
    magenta = 5;
    cyan = 6;
    white = 7;
  };

  cursor = {
    up = n: ''\e[${toString n}A'';
    down = n: ''\e[${toString n}B'';
    forward = n: ''\e[${toString n}C'';
    back = n: ''\e[${toString n}D'';

    next = n: ''\e[${toString n}E'';
    prev = n: ''\e[${toString n}F'';

    col = c: ''\e[${toString c}G'';
    pos = r: c: ''\e[${toString r};${toString c}H'';

    save = ''\e[s'';
    restore = ''\e[u'';
  };

  clear = {
    screen.toEnd = ''\e[0J'';
    screen.toBeg = ''\e[1J'';
    screen.vis = ''\e[2J'';
    screen.all = ''\e[3J'';

    line.toEnd = ''\e[0K'';
    line.toBeg = ''\e[1K'';
    line.all = ''\e[2K'';
  };

  scroll.up = n: ''\e[${toString n}S'';
  scroll.down = n: ''\e[${toString n}T'';
}
