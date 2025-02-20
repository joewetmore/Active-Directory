# https://petri.com/find-remove-inactive-accounts-from-active-directory-powershell/

get-adcomputer -filter * -properties passwordlastset | select name, passwordlastset | sort passwordlastset

$date = (get-date).addyears(-1)
or
$date = (get-date).adddays(-16).

get-adcomputer -filter {passwordlastset -lt $date} -properties passwordlastset | select name, passwordlastset | sort passwordlastset

# get-adcomputer -filter {passwordlastset -lt $date} -properties passwordlastset | remove-adobject -recursive -verbose -confirm:$false
