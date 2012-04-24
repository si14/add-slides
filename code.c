const int CODE_ONE = 1;
const int CODE_TWO = 2;

int foo() {
  if (bar()) {
      return CODE_ONE;
    } else {
      return CODE_TWO;
  }
}
