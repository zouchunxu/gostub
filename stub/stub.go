package stub

import (
	"reflect"
	"syscall"
	"unsafe"
)

func Patch(target, replacement interface{}) {
	from := reflect.ValueOf(target).Pointer()
	to := reflect.ValueOf(replacement).Pointer()

	data := jmp(to)
	copyTo(from, data)
	//f := rawMemoryAccess(from, len(data))
	//copy(f, data)
}

func copyTo(p uintptr, data []byte) {
	f := rawMemoryAccess(p, len(data))

	mprotectCrossPage(p, len(data), syscall.PROT_READ|syscall.PROT_EXEC|syscall.PROT_WRITE)
	copy(f, data[:])
	mprotectCrossPage(p, len(data), syscall.PROT_READ|syscall.PROT_EXEC)
}

func mprotectCrossPage(addr uintptr, length int, prot int) {
	pageSize := syscall.Getpagesize()
	for p := pageStart(addr); p < addr+uintptr(length); p += uintptr(pageSize) {
		page := rawMemoryAccess(p, pageSize)
		if err := syscall.Mprotect(page, prot); err != nil {
			panic(err)
		}
	}
}

func pageStart(ptr uintptr) uintptr {
	return ptr & ^(uintptr(syscall.Getpagesize() - 1))
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
