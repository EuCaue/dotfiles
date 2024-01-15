function set_bun_aliases
    alias buns='bun run start'
    alias bunb='bun run build'
    alias bunpb='bun run preview:build'
    alias bund="bun run dev"
    alias bunt="bun run test"
    alias bunpv="bun run preview"
    alias bunxv="bunx vercel"
    alias bunxvp="bunx vercel --prod"
end

set_bun_aliases
