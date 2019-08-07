program main
  use md5_mod
  implicit none
  type(md5_handle) :: handle
  character :: hash(32)
  integer, target :: idata(10)
  real, target :: rdata(10)
  integer, dimension(:), pointer :: idata_ptr
  real, dimension(:), pointer :: rdata_ptr

  hash(:) = ' '
  handle%ptr = C_NULL_PTR

  idata_ptr => idata
  rdata_ptr => rdata

  call md5_init(handle)
  call md5_update(handle, idata_ptr)
  call md5_update(handle, rdata_ptr)
  call md5_final(handle, hash)

  print *, 'md5hash: ', hash
end program
