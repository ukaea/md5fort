module md5_mod
  use iso_c_binding
  type md5_handle
    type(c_ptr) :: ptr
  end type

  interface md5_update
    module procedure md5_update_integer, md5_update_real
  end interface

  interface
    subroutine c_md5_update(ctx, data, len) bind(C, name="c_md5_update")
      use iso_c_binding
      implicit none
      type(c_ptr), intent(in) :: ctx
      type(c_ptr), intent(in) :: data
      integer(C_LONG), intent(in) :: len
    end subroutine

    subroutine c_md5_init(ctx) bind(C, name="c_md5_init")
      use iso_c_binding
      implicit none
      type(c_ptr) :: ctx
    end subroutine c_md5_init

    subroutine c_md5_final(ctx, hash) bind(C, name="c_md5_final")
      use iso_c_binding
      implicit none
      type(c_ptr), intent(in) :: ctx
      character, intent(out) :: hash(32)
    end subroutine c_md5_final
  end interface

contains

  subroutine md5_init(handle)
    implicit none
    type(md5_handle), intent(out) :: handle
    call c_md5_init(handle%ptr)
  end subroutine md5_init
  
  subroutine md5_final(handle, hash)
    implicit none
    type(md5_handle) :: handle
    character :: hash(32)
    call c_md5_final(handle%ptr, hash)
  end subroutine
  
  subroutine md5_update_integer(handle, data)
    implicit none
    type(md5_handle) :: handle
    integer, dimension(:), pointer :: data
    integer(C_LONG) :: len
    len = size(data) * 4
    call c_md5_update(handle%ptr, c_loc(data), len)
  end subroutine

  subroutine md5_update_real(handle, data)
    implicit none
    type(md5_handle) :: handle
    real, dimension(:), pointer :: data
    integer(C_LONG) :: len
    len = size(data) * 8
    call c_md5_update(handle%ptr, c_loc(data), len)
  end subroutine
end module md5_mod
