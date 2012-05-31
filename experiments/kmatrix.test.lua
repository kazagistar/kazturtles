os.loadAPI("kmatrix")
km=kmatrix

a = km.create(3)
print(textutils.serialize(a))
km.set(a, 2, 3, 4, 1)
print(textutils.serialize(a))
km.set(a, 2, 3, 5, 1)
print(textutils.serialize(a))
km.set(a, 2, 3, 4, 2)
print(textutils.serialize(a))
km.set(a, 2, 4, 5, 2)
print(textutils.serialize(a))
print(km.get(a, 2, 3, 4))

