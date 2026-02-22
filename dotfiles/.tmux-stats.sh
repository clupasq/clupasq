#!/usr/bin/env sh

# Memory
awk '/MemTotal/{t=$2}/MemAvailable/{a=$2}
END{
  u=(t-a)/1048576; tot=t/1048576; p=(t-a)*100/t
  c=(p<50)?"green":(p<80)?"yellow":"red"
  printf "#[fg=%s]MEM %.1fG/%.0fG",c,u,tot
}' /proc/meminfo

printf " "

# CPU (two samples)
l1=$(grep '^cpu ' /proc/stat)
sleep 0.2
l2=$(grep '^cpu ' /proc/stat)
awk -v l1="$l1" -v l2="$l2" '
BEGIN{
  split(l1,a); split(l2,b)
  idle1=a[5]+a[6]; idle2=b[5]+b[6]
  for(i=2;i<=8;i++){t1+=a[i];t2+=b[i]}
  dt=t2-t1; di=idle2-idle1
  p=int((dt-di)*100/dt)
  c=(p<50)?"green":(p<80)?"yellow":"red"
  printf "#[fg=%s]CPU %d%%",c,p
}'

