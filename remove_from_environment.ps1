$application_path  = '<%= @application_path  -%>'
if ($application_path - eq '') { 
  $application_path = 'C:\Program Files\Spoon\Cmd'
}

$current_path_environment = [Environment]::GetEnvironmentVariable('PATH', [System.EnvironmentVariableTarget]::Machine )

if ($current_path_environment.ToLower().Contains($application_path.ToLower())) {
  write-output ('Removing  Application path "{0}" from the MACHINE PATH environent' -f  $application_path )
  $removed = $false
  $new_path_array = @()
  $path_separator = ';'
  $current_path_environment -split $path_separator | foreach-object { 
    $path = $_
     if ( $path -ne '' -and ( -not ($path.ToLower().Contains($application_path.ToLower())))){ 
     $new_path_array += $path 
  }  else { 
     $removed = $false
  }
}
  if ($removed) { 
    Write-Host 'Removed.'
  }

[environment]::SetEnvironmentVariable('PATH', ($new_path_array -join $path_separator),[System.EnvironmentVariableTarget]::Machine)

} else { 
  Write-Host ( 'MACHINE PATH environment doew not include "{0}". ' -f $application_path )
}
