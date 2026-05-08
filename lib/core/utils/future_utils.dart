extension WaitTwo<A, B> on (Future<A>, Future<B>) {
  Future<(A, B)> get wait async {
    late A a;
    late B b;
    await Future.wait([$1.then((v) => a = v), $2.then((v) => b = v)]);
    return (a, b);
  }
}
