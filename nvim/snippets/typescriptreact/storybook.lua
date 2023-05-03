local ok, luasnip = pcall(require, "luasnip")
if not ok then
	return
end

return {
	s("story6react", fmt([[
    import { ComponentMeta, ComponentStoryObj } from '@storybook/react';
    import <> from '<>';

    /**
     * Types.
     */
    type _Meta = ComponentMeta<<typeof <>>>;
    type _StoryObj = ComponentStoryObj<<typeof <>>>;

    /**
     * Component Meta.
     */
    const meta: _Meta = {
      title: '<>',
      component: <>,
    };
    export default meta;

    /**
     * Story objects.
     */
    export const Default: _StoryObj = {};
    ]], {
      i(1), i(2), i(3), i(4), i(5), i(6)
    }, {
      delimiters = "<>",
    }
  )),
	s("storyobj6react", fmt([[
    export const <>: _StoryObj = {
      <>
    };
    ]], {
      i(1), i(2)
    }, {
      delimiters = "<>",
    }
  )),
	s("reactFnComponent", fmt([[
    import React, { FC } from 'react';

    type Props = {
      
    }

    /**
     * [] react component.
     *
     * @param props - Component props.
     */
    export const []: FC<Props> = ({ }) => {
      return (
        []
      );
    };
    ]], {
      i(1, "MySuperComponent"), i(2, "MySuperComponent"), i(3, "<div>Hello World!</div>"),
    }, {
      delimiters = "[]",
    }
  )),
}
