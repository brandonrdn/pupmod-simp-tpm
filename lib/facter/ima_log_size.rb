# Detects the size if the IMA log in bytes
Facter.add('ima_log_size') do
  confine :exists => '/sys/kernel/security/ima/ascii_runtime_measurements'

  setcode do
    Facter::Core::Execution.execute('wc -c /sys/kernel/security/ima/ascii_runtime_measurements').to_i
  end
end
