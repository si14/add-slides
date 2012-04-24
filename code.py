a = 1
b = "b"
a + b

a = 1
b = "b"
try:
    a + b
except TypeError:
    print "something bad happened"

def foobar(lst):
    a, b, c = lst

def connect_bad(db):
    if connected(db):
        return get_connection(db)
    else:
        return None

def connect_bad(db):
    return get_connection(db) if good(db) else None

def connect_better(db):
    if not good(db): log_and_raise(DbException(db))
    return get_connection(db)

def handle_req(req):
    try:
        data_handlers.handle(req.data)
    except SomeException:
        do_something()

def handle(data):
    if not test(data):
        raise SomeException()
    else:
        store(data)

def handle_req(req):
    (is_ok, result) = data_handlers.handle(req.data)
    if not is_ok: do_something()

def handle(data):
    if not test(data): return (False, 0)
    return (True, store(data))

def handle(data):
    (is_ok, foo_result) = foo(data)
    if not is_ok:
        return (False, data)
    (is_ok, bar_result) = bar(foo_result)
    if not is_ok:
        return (False, data)
    return baz(bar_result)

def handle(data):
    (is_ok, foo_result) = foo(data)
    if not is_ok:
        return False
    (is_ok, bar_result) = bar(foo_result)
    if not is_ok:
        return False
    return baz(bar_result)

a = foo();
b = bar(a, "baz");

bind(foo(),
     lambda a: bind(bar(a, "baz"),
                    lambda b: b))

def foo():
    return (True, "foo")

def bar(str1, str2):
    return (True, str1 + str2)

def bind((is_ok, value), f):
    if is_ok:
        return f(value)
    else:
        return False

def ret(value):
    return (True, value)

def ignorant_foo():
    return "foo"

bind(ret(ignorant_foo()),
     lambda a: bind(bar(a, "baz"),
                    lambda b: b))

def my_call(f, err, args*):
    try:
        return f(*args)
    except Exception as e:
        raise MyException(False, (err, e))

def my_return(x):
    raise MyException(True, x)

def test():
    try:
        conn = my_call(connect_db, "can't connect")
        data = my_call(make_request, "req error", conn)
        my_return(data)
    except MyException as e:
        return e.result if e.is_ok else e.error
