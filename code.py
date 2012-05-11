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
    (is_ok, res) = data_handlers.handle(req.data)
    if not is_ok: do_something()

def handle(data):
    if not test(data): return (False, "failed")
    return (True, store(data))

def handle(data):
    (is_ok, value) = parse(data)
    if not is_ok:
        return (False, value)
    (is_ok, value) = process(value)
    if not is_ok:
        return (False, value)
    return finalize(value)

def handle(data):
    (is_ok, foo_result) = foo(data)
    if not is_ok:
        return False
    (is_ok, bar_result) = bar(foo_result)
    if not is_ok:
        return False
    return baz(bar_result)

usr_id = auth();
status = send(usr_id, "logged");

bind(auth(),
     lambda user_id: bind(send(usr_id, "logged"),
                          lambda status: status))

def auth():
    return (True, "usr42")

def send(usr, msg):
    return (True, do_send(usr, msg))

def bind((is_ok, value), f):
    if is_ok:
        return f(value)
    else:
        return (False, value)

def ret(value):
    return (True, value)

def ignorant_auth():
    return "usr42"

bind(ret(ignorant_auth()),
     lambda user_id: bind(send(usr_id, "logged"),
                          lambda status: status))

def my_call(f, err, *args):
    try:
        return f(*args)
    except Exception as e:
        raise MyException(False, (err, e))

def my_return(x):
    raise MyException(True, x)

def test():
    try:
        conn = my_call(connect_db, "can't connect")
        data = my_call(make_req, "req error", conn)
        my_return(data)
    except MyException as e:
        return e.result if e.is_ok else e.error

def test_bad(maybe_db_data):
    connect = connect_bad(maybe_db_data)
    if not connect:
        raise Exception("ALARM")

def test_good(maybe_db_data):
    connect = connect_good(maybe_db_data)

def auth():
    if authed():
        return (True, "usr42")
    else:
        return (False, "not_authed")

def send(usr, msg):
    return (True, do_send(usr, msg))

def bind((is_ok, value), f):
    if is_ok:
        return f(value)
    else:
        return (False, value)
