import Foundation

public enum Either<A, B> {
    case left(A)
    case right(B)

    public func leftValue() -> A? {
        switch self {
        case .left(let a): return a
        case .right: return nil
        }
    }

    public func rightValue() -> B? {
        switch self {
        case .left: return nil
        case .right(let b): return b
        }
    }

    public func isLeft() -> Bool {
        switch self {
        case .left: return true
        case .right: return false
        }
    }

    public func isRight() -> Bool {
        switch self {
        case .left: return false
        case .right: return true
        }
    }

    public func fold<X>(fa: (A) -> X, fb: (B) -> X) -> X {
        switch self {
        case let .left(a): return fa(a)
        case let .right(b): return fb(b)
        }
    }

    public func toEither<X, Y>(fa: (A) -> X, fb: (B) -> Y) -> Either<X, Y> {

        return fold(fa: { (a) in
            return Either<X, Y>.left(fa(a))
            }, fb: { (b) in
                return Either<X, Y>.right(fb(b))
        })

    }

    public func leftOrElse(b: @autoclosure @escaping () -> A) -> A {
        return fold(fa: { $0 }, fb: { _ in b() })
    }

    public func rightOrElse(a: @autoclosure @escaping () -> B) -> B {
        return fold(fa: { _ in a() }, fb: { $0 })
    }
}
