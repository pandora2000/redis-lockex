require_relative 'initialize'

class Redis
  def lock(options, &proc)
    key = options.is_a?(String) ? options : extract_option(options, :key)
    interval = extract_option(options, :interval, 1)
    block = extract_option(options, :block, true)
    proc ||= extract_option(options, :proc)
    locked = extract_option(options, :locked, -> {})
    unlocked = extract_option(options, :unlocked, -> {})
    expire = extract_option(options, :expire, nil)
    k = lock_key(key)
    if block
      sleep(interval) until lock_core(k, expire)
    else
      unless lock_core(k, expire)
        return false
      end
    end
    locked.call
    if proc
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

  private

  def lock_key(key)
    "lock:#{key}"
  end

  def lock_core(key, expire)
    set(key, '', nx: true, ex: expire)
  end

  def extract_option(options, key, default = nil)
    if options.is_a?(Hash) && options.key?(key)
      options.delete(key)
    else
      default
    end
  end
end
