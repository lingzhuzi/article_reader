if [ -f 'tmp/pids/thin.pid' ] ; then
  thin restart -d
else
  thin start -d
fi

if [ ! -f 'tmp/pids/delayed_job.pid' ] ; then
  ruby bin/delayed_job start
fi

echo '服务已启动，请访问http://localhost:3000'