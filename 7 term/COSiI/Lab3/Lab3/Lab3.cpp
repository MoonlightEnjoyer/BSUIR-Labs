#include <iostream>
#include <vector>
#include <list>
#include <numeric>
#include <algorithm>

struct simple_neuron {
    enum state { LOWER_STATE = -1, UPPER_STATE = 1 };

    typedef float coeff_t;
    typedef state state_t;

    template <typename _Iv, typename _Ic>
    static state_t calculate(_Iv val_b, _Iv val_e, _Ic coeff_b) {
        auto value = std::inner_product(
            val_b,
            val_e,
            coeff_b,
            coeff_t(0)
        );

        return value > 0 ? UPPER_STATE : LOWER_STATE;
    }
};



typedef simple_neuron neuron_t;
typedef neuron_t::state_t state_t;

using std::vector;
using std::list;
using std::endl;

typedef vector<state_t> neurons_line;
typedef vector<vector<neuron_t::coeff_t>> link_coeffs;


struct neuro_net_system {
    const link_coeffs& _coeffs;
    neuro_net_system(const link_coeffs& coeffs) : _coeffs(coeffs) {}
    bool do_step(neurons_line& line) {
        bool value_changed = false;

        neurons_line old_values(begin(line), end(line));
        link_coeffs::const_iterator it_coeffs = begin(_coeffs);

        std::transform(
            begin(line),
            end(line),
            begin(line),
            [&old_values, &it_coeffs, &value_changed](state_t old_value) -> state_t {
                auto new_value = neuron_t::calculate(
                    begin(old_values),
                    end(old_values),
                    begin(*it_coeffs++)
                );

                value_changed = (new_value != old_value) || value_changed;

                return new_value;
            });

        return value_changed;
    }
    size_t _do(neurons_line& line) {
        bool need_continue = true;
        size_t steps_done = 0;

        while (need_continue) {
            need_continue = do_step(line);
            ++steps_done;
        }

        return steps_done;
    }
};

link_coeffs learn_neuro_net(const list<neurons_line>& src_images) {
    link_coeffs result_coeffs;
    size_t neurons_count = src_images.front().size();

    result_coeffs.resize(neurons_count);
    for (size_t i = 0; i < neurons_count; ++i) {
        result_coeffs[i].resize(neurons_count, 0);
    }

    for (size_t i = 0; i < neurons_count; ++i) {
        for (size_t j = 0; j < i; ++j) {
            neuron_t::coeff_t val = 0;
            val = std::accumulate(
                begin(src_images),
                end(src_images),
                neuron_t::coeff_t(0.0),
                [i, j](neuron_t::coeff_t old_val, const neurons_line& image) -> neuron_t::coeff_t {
                    return old_val + (image[i] * image[j]);
                });
            result_coeffs[i][j] = val;
            result_coeffs[j][i] = val;
        }
    }

    return result_coeffs;
}

struct neurons_line_print_descriptor {
    const neurons_line& _line;
    const size_t _width;
    const size_t _height;

    neurons_line_print_descriptor(
        const neurons_line& line,
        size_t width,
        size_t height
    ) : _line(line),
        _width(width),
        _height(height)
    {}
};

template <typename Ch, typename Tr>
std::basic_ostream<Ch, Tr>&
operator << (std::basic_ostream<Ch, Tr>& stm, const neurons_line_print_descriptor& line) {
    neurons_line::const_iterator it = begin(line._line), it_end = end(line._line);

    for (size_t i = 0; i < line._height; ++i) {
        for (size_t j = 0; j < line._width; ++j) {
            stm << neuron_t::write(*it);
            ++it;
        }
        stm << endl;
    }

    return stm;
}


int main()
{

}
