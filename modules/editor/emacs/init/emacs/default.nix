args:

{ dired = import ./dired args;
  electric = null;
  ibuffer = null;
  undo = import ./undo args;
  vc = import ./vc args;
}
