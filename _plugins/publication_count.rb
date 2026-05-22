Jekyll::Hooks.register :site, :post_read do |site|
  bib_path = File.join(site.source, '_bibliography', 'references.bib')
  next unless File.exist?(bib_path)
  count = File.read(bib_path).scan(/^@\w+\s*\{/).length
  site.config['publication_count'] = count
end
