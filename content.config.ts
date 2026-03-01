import { defineContentConfig, defineCollection, } from '@nuxt/content'
import { z, } from 'zod'

const common_schema = z.object({
  date_start: z.date(),
  date_end: z.date(),
  image: z.string(),
  tags: z.array(z.string(),),
},)

export default defineContentConfig({
  collections: {
    content: defineCollection({
      type: 'page',
      source: '**/*.md',
      schema: common_schema,
    },),
  },
},)
