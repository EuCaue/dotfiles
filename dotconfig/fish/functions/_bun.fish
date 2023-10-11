function set_bun_aliases
    alias buns='pnpm run start'
    alias bunb='pnpm run build'
    alias bunpb='pnpm run preview:build'
    alias bund="pnpm run dev"
    alias bunt="pnpm run test"
    alias bunpv="pnpm run preview"
    alias bunxv="bunx vercel"
    alias bunxvp="bunx vercel --prod"
end

set_bun_aliases
