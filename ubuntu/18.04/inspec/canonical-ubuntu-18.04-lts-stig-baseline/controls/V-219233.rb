# encoding: UTF-8

control 'V-219233' do
  title "The Ubuntu operating system must ensure only authorized groups can own
the audit log directory and its underlying files."
  desc  "If audit information were to become compromised, then forensic
analysis and discovery of the true source of potentially malicious system
activity is impossible to achieve.

    To ensure the veracity of audit information, the operating system must
protect audit information from unauthorized deletion. This requirement can be
achieved through multiple methods, which will depend upon system architecture
and design.

    Audit information includes all information (e.g., audit records, audit
settings, audit reports) needed to successfully audit information system
activity.
  "
  desc  'rationale', ''
  desc  'check', "
    Verify that the audit log directory is owned by \"root\" group.

    First determine where the audit logs are stored with the following command:

    # sudo grep -iw log_file /etc/audit/auditd.conf
    log_file = /var/log/audit/audit.log

    Using the path of the directory containing the audit logs, check if the
directory is owned by the \"root\" group by using the following command:

    # sudo stat -c \"%n %G\" /var/log/audit
    /var/log/audit root

    If the audit log directory is owned by a group other than \"root\", this is
a finding.
  "
  desc  'fix', "
    Configure the audit log directory to be owned by \"root\" group.

    First determine where the audit logs are stored with the following command:

    # sudo grep -iw log_file /etc/audit/auditd.conf
    log_file = /var/log/audit/audit.log

    Using the path of the directory containing the audit logs, configure the
audit log directory to be owned by \"root\" group by using the following
command:

    # chown -R :root /var/log/audit
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: 'SRG-OS-000059-GPOS-00029'
  tag gid: 'V-219233'
  tag rid: 'SV-219233r508662_rule'
  tag stig_id: 'UBTU-18-010310'
  tag fix_id: 'F-20957r305028_fix'
  tag cci: ['V-100693', 'SV-109797', 'CCI-000164']
  tag nist: ['AU-9']

  log_file_dir = input('log_file_dir')

  describe directory(log_file_dir) do
    its('group') { should cmp 'root' }
  end
end

