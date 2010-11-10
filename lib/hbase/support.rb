unless {}.respond_to? :symbolize_keys
  class Hash
    def symbolize_keys
      h = {}
      each{|k, v| h[k.to_sym] = v}
      h
    end
  end
end