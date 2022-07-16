
program main
implicit none
integer, parameter :: DP = 8
real(DP) :: start, finish, tfinal, dt, x,y, time, phi_previous,phi_current, v0, omega
real(DP) :: u, v, randn_x, randn_phi, randn_y, pi, D_T, D_R, r2, dx, dy
integer :: i,j, no_of_relz, dk, norm, k0, nt
real x_array(10000,10001)
real y_array(10000,10001)

tfinal = 100.0d0
dt = 0.01d0
no_of_relz = 10000
nt = tfinal/dt
 
call cpu_time(start)

open(100,file="abp_msd_final_heun_2d_3_10000nrlz.txt")

pi = 4.0d0*atan(1.0d0)
D_T = 0.22d0
D_R = 0.160d0
v0 = 3.0d0
omega = 0.0d0
 

i = 1

 do while (i .lt. no_of_relz+1)
 
     x = 0.0d0
     y = 0.0d0
     phi_previous = 0.0d0
     time = 0.0d0
     j = 1
     
     do while (time .lt. tfinal + dt)
         
         x_array(i,j) = x
         y_array(i,j) = y
         
         call random_number(u)
         call random_number(v)
         randn_x = sqrt(-2.0d0*log(u))*cos(2.0d0*pi*v)
         
         call random_number(u)
         call random_number(v)
         randn_phi = sqrt(-2.0d0*log(u))*cos(2.0d0*pi*v)
         
         call random_number(u)
         call random_number(v)
         randn_y = sqrt(-2.0d0*log(u))*cos(2.0d0*pi*v)
         
         phi_current = phi_previous + omega*dt + sqrt(2.0d0*D_R*dt)*randn_phi
         x = x + v0*dt*(cos(phi_current)+cos(phi_previous))/2 + sqrt(2.0d0*D_T*dt)*randn_x
         y = y + v0*dt*(sin(phi_current)+sin(phi_previous))/2 + sqrt(2.0d0*D_T*dt)*randn_y
         
         phi_previous = phi_current
         
         j = j + 1
         time = time + dt
         
     
     end do
     
     i = i+1
 
 end do
 
dk = 0
 do while (dk .lt. nt)
     dk = dk + 1
     norm = 0
     r2 = 0
     i = 1
     do while (i .lt. no_of_relz+1)
         k0 = 0
         do while (k0 .lt. nt-dk+1) 
             k0 = k0 + 1
             dx = x_array(i,k0+dk) - x_array(i,k0)
             dy = y_array(i,k0+dk) - y_array(i,k0)
             r2 = r2 + dx*dx + dy*dy
             norm = norm + 1
             
         
         end do             
         i = i+1
     end do
     write(100,*) dk*dt,r2/norm
 end do
 
#i = 1
#do while (i .lt. no_of_relz+1)
#print *, "saving file"
#	write(100,*) (x_array(i,j), j=1,10000)
#	i = i+1
#end do

# write(100,*) ((x_array(i,time),i= 1,10),time= 0,10)
# write(100,*)dt,
close(100)
call cpu_time(finish)
print *,finish-start
end program





    

    
    


 
