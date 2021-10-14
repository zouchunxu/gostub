package stub

import (
	"reflect"
	"unsafe"
)

func Patch(target, replacement interface{}) {
	from := reflect.ValueOf(target).Pointer()
	to := reflect.ValueOf(replacement).Pointer()

	data := jmp(to)
	f := rawMemoryAccess(from, len(data))
	copy(f, data)
}

func rawMemoryAccess(p uintptr, length int) []byte {
	return *(*[]byte)(unsafe.Pointer(&reflect.SliceHeader{
		Data: p,
		Len:  length,
		Cap:  length,
	}))
}

func jmp(to uintptr) []byte {
	return []byte{
		0x48, 0xBA, // movabs rdx
		byte(to),
		byte(to >> 8),
		byte(to >> 16),
		byte(to >> 24),
		byte(to >> 32),
		byte(to >> 40),
		byte(to >> 48),
		byte(to >> 56), // movabs rdx,to
		0xFF, 0xE2,     // jmp rdx
	}
}
