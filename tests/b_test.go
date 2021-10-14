package tests

import (
	"sync"
	"sync/atomic"
	"testing"
)

func BenchmarkSplit(t *testing.B) {
	i := 0
	s := sync.Mutex{}
	for j := 0; j < t.N; j++ {
		s.Lock()
		_ = i
		s.Unlock()
	}
}
func BenchmarkSplit2(t *testing.B) {
	i := 0
	s := atomic.Value{}
	s.Store(i)
	for j := 0; j < t.N; j++ {
		_ = s.Load()
	}
}
