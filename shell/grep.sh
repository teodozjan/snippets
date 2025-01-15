/usr/share/dict/american-english | grep -Px '\w{5}' | grep -P '^(?=.*s)(?=.*u)(?=.*o)' | grep -Pv '[aeyriglhp]'
