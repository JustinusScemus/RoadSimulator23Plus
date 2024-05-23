abstract static class Infrastructure {
  public int getMagicNumber() {return 0;}
  public int getDenominator() {return 1000;}
}

class House extends Infrastructure {
  @Override
  int getMagicNumber() {return 1020;}
  @Override
  int getDenominator() {return 1050;}
}

class Village extends Infrastructure {
  @Override int getMagicNumber() {return 2;}
  @Override int getDenominator() {return 500;}
}

class ResTower extends Infrastructure {
  @Override int getMagicNumber() {return 35;}
  @Override int getDenominator() {return 100;}
}
