-----------------
--  Functions  --
-----------------
function get_pass(account)
    local password_prg = 'pass' -- I use the pass program to store passwords
    local mail_prefix = 'Mail/' -- Folder of mail account in password store
    local cmd = string.format('%s %s%s', password_prg, mail_prefix, account)
    local output = {}

    local file = assert(io.popen(cmd, 'r'))
    local k = 1
    for line in file:lines() do
       output[k] = line
       k = k + 1
    end
    -- local output = file:read('*all')
    file:close()
    return output[1]
end

---------------
--  Options  --
---------------

options.timeout = 120
options.subscribe = true

----------------
--  Accounts  --
----------------

-- user@email7.com
mailing_acc = IMAP {
    server = 'mail.net-c.com',
    username = 'user@email7.com',
    password = get_pass('user@email7.com'),
}

-- user@email2.com
main_acc = IMAP {
    server = 'imap.gmail.com',
    username = 'user@email2.com',
    password = get_pass('user@email2.com'),
    ssl = "tls1"
}

-- user@email5.com.com
junk_acc = IMAP {
    server = 'imap-mail.outlook.com',
    username = 'user@email5.com.com',
    password = get_pass('user@email5.com.com'),
}

-- For test purposes
-- mailing_acc.inbox:check_status()
-- main_acc.INBOX:check_status()
-- junk_acc.Inbox:check_status()

---------------
--  Filters  --
---------------

-- filter zsh workers
local result = mailing_acc['inbox']:contain_to('zsh-workers@zsh.org') +
               mailing_acc['inbox']:contain_cc('zsh-workers@zsh.org')
result:move_messages(mailing_acc['zsh-workers'])

-- filter zsh users
result = mailing_acc['inbox']:contain_to('zsh-users@zsh.org') +
         mailing_acc['inbox']:contain_cc('zsh-users@zsh.org')
result:move_messages(mailing_acc['zsh-users'])

-- move all mail from social to inbox. For some reason vim mailing list goes to
-- the social folder of netcourrier
result = mailing_acc['social']:select_all()
result:move_messages(mailing_acc['inbox'])

-- filter vim-use
result = mailing_acc['inbox']:contain_to('vim_use@googlegroups.com') +
         mailing_acc['inbox']:contain_cc('vim_use@googlegroups.com')
result:move_messages(mailing_acc['vim-use'])

result = main_acc['INBOX']:contain_from('unwanted@email.com')
result:delete_messages()

result = junk_acc['Inbox']:contain_from('unwanted@email.com')
result:delete_messages()
