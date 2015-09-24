if [ -f 'tmp/pids/thin.pid' ] ; then
  thin stop
fi

if [ -f 'tmp/pids/delayed_job.pid' ] ; then
  ruby bin/delayed_job stop
fi

echo '服务已关闭'