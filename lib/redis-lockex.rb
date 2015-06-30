require_relative 'initialize'

class Redis
  def lock(arg_key = nil, key: nil, interval: 1, block: true, proc: nil, locked: -> {}, unlocked: -> {}, expire: nil, &arg_proc)
    key ||= arg_key
    proc ||= arg_proc
    k = lock_key(key)
    if block
      sleep(interval) until lock_core(k, expire)
    else
      return false unless lock_core(k, expire)
    end
    if proc
      locked.call
      begin
        proc.call
      ensure
        unlock(key)
        unlocked.call
      end
    else
      key
    end
  end

  def unlock(key)
    k = lock_key(key)
    del(k)
  end

  def locked?(key)
    k = lock_key(key)
    exists(k)
  end

  private

  def lock_key(key)
    "lock:#{key}"
  end

  def lock_core(key, expire)
    set(key, '', nx: true, ex: expire)
  end
end
